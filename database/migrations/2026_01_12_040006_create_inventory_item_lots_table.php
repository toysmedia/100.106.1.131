<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('inventory_item_lots', function (Blueprint $table) {
            $table->id();
            $table->string('lot_number')->unique();
            $table->unsignedBigInteger('item_id');
            $table->unsignedBigInteger('receipt_id')->nullable(); // MUST be nullable for 'on delete set null'
            $table->integer('quantity');
            $table->date('expiry_date')->nullable();
            $table->timestamps();

            // Foreign key constraint with 'on delete set null'
            // This requires receipt_id to be nullable
            $table->foreign('receipt_id')
                  ->references('id')
                  ->on('inventory_receipts')
                  ->onDelete('set null');
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('inventory_item_lots');
    }
};
